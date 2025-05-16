from Calculadora import Calculadora


def test_somar():
    assert Calculadora.somar(1, 2) == 3
    assert Calculadora.somar(7, 3) == 10
    assert Calculadora.somar(2, 5) == 7

def test_subtrair():
    assert Calculadora.subtrair(3, 5) == -2
    assert Calculadora.subtrair(7, 4) == 3
    assert Calculadora.subtrair(3500, 500) == 3000

def test_multiplicar():
    assert Calculadora.multiplicar(5, 5) == 25
    assert Calculadora.multiplicar(9, 9) == 81
    assert Calculadora.multiplicar(30, 10) == 300

def test_dividir():
    assert Calculadora.dividir(10, 2) == 5
    assert Calculadora.dividir(10000, 2) == 5000
    assert Calculadora.dividir(700, 7) == 100