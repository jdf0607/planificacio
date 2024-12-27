(define (problem letseat-simple)
	(:domain letseat)
	(:objects
	arm - robot
	cupcake  - cupcake
	unicorn - unicorn
	table - location
	plate - location
	)

	(:init
		(on arm table)
		(on cupcake table)
		(on unicorn plate)
		(arm-empty)
		(path table plate)
		(path plate table)
	)
	(:goal 
		(eaten cupcake plate)
	)
)