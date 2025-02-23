#!/usr/bin/env python3

import random

class ProblemaPDDL:

    def __init__(self, nom, dom):
        self.__nom = nom
        self.__domini = dom
        self.__objectes = {} # Treballem amb problemes amb objectes tipats
        self.__predicatsIni = [] # Predicats en forma de tupla
        self.__predicatsObj = []
        self.__indentacio = "   "

    def afegirObjecte(self, tipus, nom):
        if not (tipus in self.__objectes):
            self.__objectes[tipus] = [nom]
        else:
            self.__objectes[tipus].append(nom)

    def afegirPredicatInicial(self, pred):
        self.__predicatsIni.append(pred)

    def obtenirPredicatsIniPerTipus(self, tipus):
        return [p for p in self.__predicatsIni if p[0] == tipus]

    def modificarPredicatInicial(self, predOriginal, predNou):
        self.__predicatsIni = [predNou if p == predOriginal else p for p in self.__predicatsIni]

    def afegirFuncioInicial(self, op, pred, valIni):
        parLlista = ["("]
        parLlista.extend(pred)
        parLlista.append(")")
        par = " ".join(parLlista)
        self.__predicatsIni.append((op, par, valIni))

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

def generarContinguts(problema: ProblemaPDDL):
    numConts = int(input("Introduir el nombre de continguts a crear: "))
    for i in range (1, numConts + 1):
        problema.afegirObjecte("contingut",  "cont" + str(i))
    return numConts

def generarDies(problema: ProblemaPDDL):
    numDies = int(input("Introduir el nombre de dies de marge: "))
    for i in range (1, numDies + 1):
        problema.afegirObjecte("dia", "dia" + str(i))
    return numDies

def generarPredecessors(problema: ProblemaPDDL, numConts):
    parells, i = [], 0
    while i < random.randrange(numConts // 2, numConts * 2 + 1):
        pred, succ = random.randrange(1, numConts + 1), random.randrange(1, numConts + 1)
        if ((pred, succ) in parells) or ((succ, pred) in parells) or pred == succ:
            continue
        parells.append((pred, succ))
        i += 1
    for p in parells:
        problema.afegirPredicatInicial(("predecessor", "cont" + str(p[0]), "cont" + str(p[1])))
    return parells

def generarSeqDies(problema: ProblemaPDDL, numDies):
    for di in range(1, numDies):
        for df in range(di, numDies):
            problema.afegirPredicatInicial(("dia-seguent", "dia" + str(di), "dia" + str(df + 1)))

def generarDiesConsec(problema: ProblemaPDDL, numDies):
    for d in range(1, numDies):
        problema.afegirPredicatInicial(("dies-consecutius", "dia" + str(d), "dia" + str(d + 1)))

def generarContingutsJaVistos(problema: ProblemaPDDL, numConts):
    contsVistos = []
    for _ in range(0, random.randrange(0, numConts // 2)):
        c = random.randrange(1, numConts + 1)
        while c in contsVistos:
            c = random.randrange(1, numConts + 1)
        contsVistos.append(c)
        problema.afegirPredicatInicial(("continguts-vistos", "cont" + str(c)))
    return contsVistos

def generarContingutsPerVeure(problema: ProblemaPDDL, numConts, contsVistos):
    i = 0
    while i < random.randrange(1, numConts - len(contsVistos) + 1):
        c = random.randrange(1, numConts + 1)
        if c in contsVistos:
            continue
        contsVistos.append(c)
        predsParalels = problema.obtenirPredicatsIniPerTipus("paralel")
        for pp in predsParalels:
            if pp[2] == "cont" + str(c):
                problema.modificarPredicatInicial(pp, (pp[0], pp[2], pp[1]))
        problema.afegirPredicatObjectiu(("continguts-vistos", "cont" + str(c)))
        i += 1

def generarParalels(problema: ProblemaPDDL, numConts, parells):
    i = 0
    precedents = set({})
    for p in parells:
        precedents.add(p[0])
    while i < random.randrange(1, numConts - len(precedents)):
        p1 = random.randrange(1, numConts)
        p2 = random.randrange(p1 + 1, numConts + 1)
        if (p1 in precedents) or (p2 in precedents) or ((p1, p2) in parells):
            continue
        parells.append((p1, p2))
        problema.afegirPredicatInicial(("paralel", "cont" + str(p1), "cont" + str(p2)))
        i += 1
    return parells

def generarAssignacionsDies(problema: ProblemaPDDL, numDies):
    for d in range(1, numDies + 1):
        problema.afegirPredicatInicial(("assignacions-3", "dia" + str(d)))

def generarTempsContinguts(problema: ProblemaPDDL, numConts):
    for c in range(1, numConts + 1):
        mins = random.randrange(25, 180, 5)
        problema.afegirFuncioInicial("=", ("minutsVisionat", "cont" + str(c)), str(mins))

def generarValorsInicialsDies(problema: ProblemaPDDL, numDies):
    for d in range(1, numDies + 1):
        problema.afegirFuncioInicial("=", ("contingutsEnDia", "dia" + str(d)), "0")
        problema.afegirFuncioInicial("=", ("minutsEnDia", "dia" + str(d)), "0")

def domini1(nomProb):
    problema = ProblemaPDDL(nomProb, "domini")
    numConts = generarContinguts(problema)
    numDies = generarDies(problema)
    generarPredecessors(problema, numConts)
    generarSeqDies(problema, numDies)
    contsVistos = generarContingutsJaVistos(problema, numConts)
    generarContingutsPerVeure(problema, numConts, contsVistos)
    problema.generarProblema()

def domini2(nomProb):
    problema = ProblemaPDDL(nomProb, "domini")
    numConts = generarContinguts(problema)
    numDies = generarDies(problema)
    parells = generarPredecessors(problema, numConts)
    generarParalels(problema, numConts, parells)
    generarSeqDies(problema, numDies)
    generarDiesConsec(problema, numDies)
    contsVistos = generarContingutsJaVistos(problema, numConts)
    generarContingutsPerVeure(problema, numConts, contsVistos)
    problema.generarProblema()

def domini3(nomProb):
    problema = ProblemaPDDL(nomProb, "domini")
    numConts = generarContinguts(problema)
    numDies = generarDies(problema)
    parells = generarPredecessors(problema, numConts)
    generarParalels(problema, numConts, parells)
    generarSeqDies(problema, numDies)
    generarAssignacionsDies(problema, numDies)
    contsVistos = generarContingutsJaVistos(problema, numConts)
    generarContingutsPerVeure(problema, numConts, contsVistos)
    problema.generarProblema()

def domini4(nomProb):
    problema = ProblemaPDDL(nomProb, "domini")
    numConts = generarContinguts(problema)
    numDies = generarDies(problema)
    parells = generarPredecessors(problema, numConts)
    generarParalels(problema, numConts, parells)
    generarTempsContinguts(problema, numConts)
    generarSeqDies(problema, numDies)
    generarValorsInicialsDies(problema, numDies)
    contsVistos = generarContingutsJaVistos(problema, numConts)
    generarContingutsPerVeure(problema, numConts, contsVistos)
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
elif numOpcio == 2:
    domini2(nomProb)
elif numOpcio == 3:
    domini3(nomProb)
elif numOpcio == 4:
    domini4(nomProb)