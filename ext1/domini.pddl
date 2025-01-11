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
        (dia-seguent ?dia1 - dia ?dia2 - dia)
        )
    (:action afegir-visionat
        :parameters (?veure - contingut ?dia - dia)
        :precondition (and
            (not (continguts-vistos ?veure)) ;;El contingut encara no ha sigut visionat

            ;; Per tots els predecessors del contingut a veure, assegurem que:
            ;; 1. No es un predecessor
            ;; 2.Si es un predecessor, aquest ja ha sigut visionat i no ha sigut assignat al dia actual
            ; (forall (?p - contingut)
            ;     (or 
            ;         (not (predecessor ?p ?veure)) ; No es predecessor
            ;         (and
            ;             (continguts-vistos ?p)    ; El predecessor ha sigut visionat
            ;             (forall (?dp - dia)
            ;                 (imply
            ;                     (assignat-a-dia ?p ?dp) 
            ;                     (dia-seguent ?dp ?dia)  
            ;                 )
            ;             )
            ;         )
            ;     )
            ; )
            (forall (?p - contingut ?d - dia) 
                (imply (predecessor ?p ?veure)
                    (and
                        (continguts-vistos ?p)
                        (imply (assignat-a-dia ?p ?d)
                            (dia-seguent ?d ?dia)
                        )
                    )
                )
            )
        )
        :effect (and (assignat-a-dia ?veure ?dia) (continguts-vistos ?veure)   )
    )
)