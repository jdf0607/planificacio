;aquest arxiu serà pel domini
(define (domain domini)
        (:requirements :typing :adl)
        (:types
            contingut - object
            dia - object
        )
    (:predicates
        (predecessor ?precedent - contingut ?seguent - contingut)
        (continguts-vistos ?continguts - contingut)
        (assignat-a-dia ?contingut - contingut ?dia  - dia)
        (paralel ?c1 - contingut ?c2 - contingut)
        (dia-seguent ?dia1 - dia ?dia2 - dia)
        )
     (:action afegir-visionat
        :parameters (?veure - contingut ?dia - dia)
        :precondition (and
            (not (continguts-vistos ?veure)) ;;El contingut encara no ha sigut visionat

            ;; Per tots els predecessors del contingut a veure, assegurem que:
            ;; 1. No es un predecessor
            ;; 2.Si es un predecessor, aquest ja ha sigut visionat i no ha sigut assignat al dia actual
            (forall (?p - contingut)
                (or 
                    (not (predecessor ?p ?veure)) ; No es predecessor
                    (and
                        (continguts-vistos ?p)    ; El predecessor ha sigut visionat
                        (forall (?dp - dia)
                            (imply
                                (assignat-a-dia ?p ?dp) 
                                (dia-seguent ?dp ?dia)  
                            )
                        )
                    )
                )
            )
            (forall (?p - contingut)
                (or 
                    (and (not (paralel ?veure ?p))
                        (not (paralel ?p ?veure))) ;no son paralels
                    (and (continguts-vistos ?p)
                        (or (assignat-a-dia ?p ?dia)
                            (exists 
                                (?d - dia) 
                                (and (assignat-a-dia ?p ?d) (dia-seguent ?d ?dia))                
                            )
                         )) ;el contingut ja està al visionat
                    (or (assignat-a-dia ?p ?dia)
                        (exists (?d - dia) (and (assignat-a-dia ?p ?d) (dia-seguent ?d ?dia)))
                    ); el contingut és veu el mateix dia o al dia anterior
                    (and (not (continguts-vistos ?p))
                        (not (exists (?p2 - contingut) (and (not (continguts-vistos ?p))(predecessor ?p2 ?p))))
                    ) ;el contingut no ha sigut vist peró no li fa falta cap predecessor per ser vist
                    ;assegutem no veure un contingut si d'un paralel seu no hem vist els seus predecessors.
                )

            )
            
        )
        :effect (and (assignat-a-dia ?veure ?dia)(continguts-vistos ?veure))
    
    )
)