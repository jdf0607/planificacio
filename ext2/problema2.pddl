(define (problem problema2)
   (:domain domini)
   (:objects
      cont1 cont2 cont3 cont4 cont5 - contingut
      dia7 dia6 dia5 dia4 dia3 dia2 dia1 - dia
   )
   (:init
      (predecessor cont5 cont1 )
      (predecessor cont3 cont1 )
      (paralel cont3 cont4 )
      (paralel cont1 cont2 )
      (dia-seguent dia1 dia2 )
      (dia-seguent dia1 dia3 )
      (dia-seguent dia1 dia4 )
      (dia-seguent dia1 dia5 )
      (dia-seguent dia1 dia6 )
      (dia-seguent dia1 dia7 )
      (dia-seguent dia2 dia3 )
      (dia-seguent dia2 dia4 )
      (dia-seguent dia2 dia5 )
      (dia-seguent dia2 dia6 )
      (dia-seguent dia2 dia7 )
      (dia-seguent dia3 dia4 )
      (dia-seguent dia3 dia5 )
      (dia-seguent dia3 dia6 )
      (dia-seguent dia3 dia7 )
      (dia-seguent dia4 dia5 )
      (dia-seguent dia4 dia6 )
      (dia-seguent dia4 dia7 )
      (dia-seguent dia5 dia6 )
      (dia-seguent dia5 dia7 )
      (dia-seguent dia6 dia7 )
      (dies-consecutius dia1 dia2 )
      (dies-consecutius dia2 dia3 )
      (dies-consecutius dia3 dia4 )
      (dies-consecutius dia4 dia5 )
      (dies-consecutius dia5 dia6 )
      (dies-consecutius dia6 dia7 )
   )
   (:goal (and
      (continguts-vistos cont5 )
      (continguts-vistos cont1 )
   ))
)