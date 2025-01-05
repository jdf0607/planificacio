#!/usr/bin/env python3

import random

class ProblemaPDDL:

    def __init__(self, nom, dom):
        self.__nom = nom
        self.__domini = dom
        self.__objectes = {} # Treballem amb problemes amb objectes tipats
        self.__predicatsIni = [] # Predicats en forma de tupla
        self.__predicatsObj = []
        self.__indentacio = "   " # Un espai menys que la indentació que es desitja

    def afegirObjecte(self, tipus, nom):
        if not (tipus in self.__objectes):
            self.__objectes[tipus] = [nom]
        else:
            self.__objectes[tipus].append(nom)

    def afegirPredicatInicial(self, pred):
        self.__predicatsIni.append(pred)

    def afegirPredicatObjectiu(self, pred):
        self.__predicatsObj.append(pred)

    def generarProblema(self):
        # Capçalera
        contingut = ["(define ", "(problem ", self.__nom + ")\n"]
        contingut.extend([self.__indentacio, "(:domain ", self.__domini + ")\n"])
        # Objectes
        contingut.extend([self.__indentacio, "(:objects\n"])
        for tipus in self.__objectes:
            contingut.extend([self.__indentacio, self.__indentacio])
            for o in self.__objectes[tipus]:
                contingut.extend([o, " "])
            contingut.extend(["- ", tipus + "\n"])
        contingut.extend([self.__indentacio, ")\n"])
        # Predicats inicials
        contingut.extend([self.__indentacio, "(:init\n"])
        for pred in self.__predicatsIni:
            contingut.extend([self.__indentacio, self.__indentacio, "("])
            for elem in pred:
                contingut.extend([elem, " "])
            contingut.extend(")\n")
        contingut.extend([self.__indentacio, ")\n"])
        # Predicats objectiu
        contingut.extend([self.__indentacio, "(:goal ", "(and\n"])
        for pred in self.__predicatsObj:
            contingut.extend([self.__indentacio, self.__indentacio, "("])
            for elem in pred:
                contingut.extend([elem, " "])
            contingut.extend(")\n")
        contingut.extend([self.__indentacio, "))\n)"])
        # Escriptura a fitxer
        fitxer = open(self.__nom + ".pddl", mode = "w")
        fitxer.writelines(contingut)
        fitxer.close()

def domini1(nomProb):
    problema = ProblemaPDDL(nomProb, "domini")
    numConts = int(input("Introduir el nombre de continguts a crear: "))
    for i in range (1, numConts + 1):
        problema.afegirObjecte("contingut",  "cont" + str(i))
    numDies = int(input("Introduir el nombre de dies de marge: "))
    for i in range (1, numDies + 1):
        problema.afegirObjecte("dia", "dia" + str(i))
    parells, i = [], 0
    while i < random.randrange(numConts // 2, numConts * 2 + 1):
        pred, succ = random.randrange(1, numConts + 1), random.randrange(1, numConts + 1)
        if ((pred, succ) in parells) or ((succ, pred) in parells) or pred == succ:
            continue
        parells.append((pred, succ))
        i += 1
    for p in parells:
        problema.afegirPredicatInicial(("predecessor", "cont" + str(p[0]), "cont" + str(p[1])))
    for d in range(1, numDies):
        problema.afegirPredicatInicial(("dia-seguent", "dia" + str(d), "dia" + str(d + 1)))
    contsVistos = []
    for _ in range(0, random.randrange(0, numConts // 2)):
        c = random.randrange(1, numConts + 1)
        contsVistos.append(c)
        problema.afegirPredicatInicial(("continguts-vistos", "cont" + str(c)))
    i = 0
    while i < random.randrange(1, numConts - len(contsVistos) + 1):
        c = random.randrange(1, numConts + 1)
        if c in contsVistos:
            continue
        contsVistos.append(c)
        problema.afegirPredicatObjectiu(("continguts-vistos", "cont" + str(c)))
        i += 1
    problema.generarProblema()

nomProb = input("Introduir el nom del fitxer de problema per crear: ")
print("Seleccionar amb el nombre corresponent per a quina extensió del domini es vol generar un problema:")
print("\t1. Continguts predecessors, planificats en dies anteriors.")
print("\t2. L'anterior més continguts paral·lels, planificats el mateix dia o l'anterior.")
print("\t3. Els anteriors més restricció de no més de tres continguts per dia.")
print("\t4. Els anteriors més restricció de no més de 200 minuts de visionat per dia.")
numOpcio = 0
while not (numOpcio in range(1, 5)):
    numOpcio = int(input("Introduir el nombre de selecció: "))
if numOpcio == 1:
    domini1(nomProb)