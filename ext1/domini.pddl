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
        )
        :effect (and (assignat-a-dia ?veure ?dia)(continguts-vistos ?veure))
    
    )
)