(define (problem problema)
	(:domain domini)
	(:objects
		c1 c2 c3 c4 c5 - contingut
	)
	(:init 
		(predecessor c1 c2)
        (predecessor c2 c3)
        (predecessor c3 c4)
        (predecessor c4 c5)
    )
        
	(:goal (continguts-vistos c4))

	)