(define (problem problema)
	(:domain domini)
	(:objects
		c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 - contingut
		dia1 dia2 dia3 dia4 dia5 dia6 dia7 dia8 dia9 dia10 - dia
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
		(dia-seguent dia1 dia3)
		(dia-seguent dia1 dia4)
		(dia-seguent dia1 dia5)
		(dia-seguent dia1 dia6)
		(dia-seguent dia1 dia7)
		(dia-seguent dia1 dia8)
		(dia-seguent dia1 dia9)
		(dia-seguent dia1 dia10)
		(dia-seguent dia2 dia3)
		(dia-seguent dia2 dia4)
		(dia-seguent dia2 dia5)
		(dia-seguent dia2 dia6)
		(dia-seguent dia2 dia7)
		(dia-seguent dia2 dia8)
		(dia-seguent dia2 dia9)
		(dia-seguent dia2 dia10)
		(dia-seguent dia3 dia4)
		(dia-seguent dia3 dia5)
		(dia-seguent dia3 dia6)
		(dia-seguent dia3 dia7)
		(dia-seguent dia3 dia8)
		(dia-seguent dia3 dia9)
		(dia-seguent dia3 dia10)
		(dia-seguent dia4 dia5)
		(dia-seguent dia4 dia6)
		(dia-seguent dia4 dia7)
		(dia-seguent dia4 dia8)
		(dia-seguent dia4 dia9)
		(dia-seguent dia4 dia10)
		(dia-seguent dia5 dia6)
		(dia-seguent dia5 dia7)
		(dia-seguent dia5 dia8)
		(dia-seguent dia5 dia9)
		(dia-seguent dia5 dia10)
		(dia-seguent dia6 dia7)
		(dia-seguent dia6 dia8)
		(dia-seguent dia6 dia9)
		(dia-seguent dia6 dia10)
		(dia-seguent dia7 dia8)
		(dia-seguent dia7 dia9)
		(dia-seguent dia7 dia10)
		(dia-seguent dia8 dia9)
		(dia-seguent dia8 dia10)
		(dia-seguent dia9 dia10)
		(dies-consecutius dia1 dia2 )
		(dies-consecutius dia2 dia3 )
		(dies-consecutius dia3 dia4 )
		(dies-consecutius dia4 dia5 )
		(dies-consecutius dia5 dia6 )
		(dies-consecutius dia6 dia7 )
		(dies-consecutius dia7 dia8 )
		(dies-consecutius dia8 dia9 )
		(dies-consecutius dia9 dia10 )

		(assignacions-3 dia1)
		(assignacions-3 dia2)
		(assignacions-3 dia3)
		(assignacions-3 dia4)
		(assignacions-3 dia5)
		(assignacions-3 dia6)
		(assignacions-3 dia7)
		(assignacions-3 dia8)
		(assignacions-3 dia9)
		(assignacions-3 dia10)
    )
        
	(:goal (and (continguts-vistos c1) 
				(continguts-vistos c2) 
				(continguts-vistos c3) 
				(continguts-vistos c4) 
				(continguts-vistos c5) 
				(continguts-vistos c6) 
				(continguts-vistos c7) 
				(continguts-vistos c8)
				(continguts-vistos c9)
				(continguts-vistos c10)))

)