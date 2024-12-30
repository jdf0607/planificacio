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
        :parameters (
            ?cal_veure - contingut
            ?per_veure - contingut
        )
        :precondition (and
            (predecessor ?cal_veure ?per_veure)
            (not (continguts-vistos ?cal_veure))
        )
        :effect (and 
            (continguts-vistos ?cal_veure))
    )

)