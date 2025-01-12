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
        (dies-consecutius ?dia1 - dia ?dia2 - dia)
        (assignacions-3 ?dia - dia)  
        (assignacions-2 ?dia - dia)  
        (assignacions-1 ?dia - dia)  
        (assignacions-0 ?dia - dia)  
        )
    (:action afegir-visionat
       :parameters (?veure - contingut ?dia - dia)
       :precondition (and
          (not (continguts-vistos ?veure)) ;;El contingut encara no ha sigut visionat

          ;; Per tots els predecessors del contingut a veure, assegurem que:
          ;; 1. No es un predecessor
          ;; 2.Si es un predecessor, aquest ja ha sigut visionat i no ha sigut assignat al dia actual
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
            (forall (?p - contingut ?d - dia) 
                (imply (paralel ?veure ?p)
                    (and
                        (continguts-vistos ?p)
                        (imply (assignat-a-dia ?p ?d)
                            (or (= ?d ?dia) (dies-consecutius ?d ?dia))
                        )
                    )
                )
            )
          (or 
            (assignacions-3 ?dia)
            (assignacions-2 ?dia)
            (assignacions-1 ?dia)   
         )
       )
       :effect (and 
               (assignat-a-dia ?veure ?dia)
               (continguts-vistos ?veure)

               (when (assignacions-1 ?dia)
                  (and (assignacions-0 ?dia)
                       (not (assignacions-1 ?dia))))
               
               (when (assignacions-2 ?dia)
                  (and (assignacions-1 ?dia)
                       (not (assignacions-2 ?dia))))
                     
               (when (assignacions-3 ?dia)
                  (and (assignacions-2 ?dia)
                       (not (assignacions-3 ?dia))))
               
       )
    )
)