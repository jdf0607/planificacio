(define (problem problema2)
   (:domain domini)
   (:objects
      cont1 cont2 cont3 cont4 cont5 cont6 cont7 - contingut
      dia5 dia4 dia3 dia2 dia1 - dia
   )
   (:init
      (predecessor cont4 cont2 )
      (predecessor cont7 cont1 )
      (predecessor cont4 cont5 )
      (predecessor cont7 cont4 )
      (predecessor cont2 cont1 )
      (predecessor cont6 cont4 )
      (predecessor cont7 cont3 )
      (dia-seguent dia1 dia2 )
      (dia-seguent dia2 dia3 )
      (dia-seguent dia3 dia4 )
      (dia-seguent dia4 dia5 )
      (continguts-vistos cont5 )
   )
   (:goal (and
      (continguts-vistos cont3 )
      (continguts-vistos cont7 )
   ))
)