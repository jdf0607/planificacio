;aquest arxiu serà pel domini
(define (domain domini)
        (:requirements :typing :adl)
        (:types
            contingut - object
        )
    (:predicates
        (predecessor ?precedent - contingut ?seguent - contingut)
        (continguts-vistos ?continguts - contingut)
        
        )
     (:action afegir-visionat
        :parameters (?veure - contingut)
        :precondition (and
            (forall (?p - contingut)
                (or 
                    (not (predecessor ?p ?veure)) 
                    (continguts-vistos ?p)       
                )
            )
            (not (continguts-vistos ?veure))     
        )
        :effect (and
            (continguts-vistos ?veure)
        )
    )

)