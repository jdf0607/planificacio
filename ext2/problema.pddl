(define (problem problema)
	(:domain domini)
	(:objects
		c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 - contingut
		dia8 dia7 dia6 dia5 dia4 dia3 dia2 dia1 - dia
	)
	(:init 
		(predecessor c1 c3)
		(predecessor c2 c3)
		(predecessor c3 c4)
        (predecessor c4 c5)
        (predecessor c5 c6)
        (predecessor c8 c9)
         (predecessor c9 c10)
         
         (paralel c6 c7)
         
		(dia-seguent dia1 dia2)
		(dia-seguent dia2 dia3)
		(dia-seguent dia3 dia4)
		(dia-seguent dia4 dia5)
		(dia-seguent dia5 dia6)
		(dia-seguent dia6 dia7)
    )
        
	(:goal (and (continguts-vistos c7) (continguts-vistos c10)))

)