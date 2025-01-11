(define (problem problema2)
   (:domain domini)
   (:objects
      cont1 cont2 cont3 cont4 cont5 - contingut
      dia7 dia6 dia5 dia4 dia3 dia2 dia1 - dia
   )
   (:init
      (predecessor cont2 cont5 )
      (predecessor cont5 cont1 )
      (predecessor cont3 cont1 )
      (paralel cont3 cont4 )
      (paralel cont3 cont5 )
      (paralel cont2 cont4 )
      (dia-seguent dia1 dia2 )
      (dia-seguent dia2 dia3 )
      (dia-seguent dia3 dia4 )
      (dia-seguent dia4 dia5 )
      (dia-seguent dia5 dia6 )
      (dia-seguent dia6 dia7 )
   )
   (:goal (and
      (continguts-vistos cont3 )
   ))
)