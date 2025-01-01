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
            (not (continguts-vistos ?veure))
            (forall (?p - contingut)
                (or 
                    (not (predecessor ?p ?veure)) ;no es predecessor
                    (and (predecessor ?p ?veure) 
                         (continguts-vistos ?p)
                         (not (assignat-a-dia ?p ?dia)) ;es predecessor i s'ha vist o assignat per veure
                   )
                )
            )
            (forall (?p - contingut)
                (or 
                    (and (not (paralel ?veure ?p))
                        (not (paralel ?p ?veure)))
                    (continguts-vistos ?p)
                    (or (assignat-a-dia ?p ?dia)
                        (exists (?d - dia) (and (assignat-a-dia ?p ?d) (dia-seguent ?dia ?d)))
                    )
                    (and (not (continguts-vistos ?p))
                        (not (exists (?p2 - contingut) (and (not (continguts-vistos ?p))(predecessor ?p2 ?p))))
                    )
                )

            )
            
        )
        :effect (and (assignat-a-dia ?veure ?dia)(continguts-vistos ?veure))
    
    )
)