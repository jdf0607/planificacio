(define (problem problema)
	(:domain domini)
	(:objects
		c1 c2 c3 c4 c5 c8 c9 c10 - contingut
	)
	(:init 
		(predecessor c1 c3)
		(predecessor c2 c3)
		(predecessor c3 c4)
        (predecessor c4 c5)
        
        (predecessor c8 c9)
         (predecessor c9 c10)
    )
        
	(:goal (and (continguts-vistos c5) (continguts-vistos c10)))

	)