class Nod:
    def __init__(self, e):
        self.e = e
        self.urm = None
    
class Lista:
    def __init__(self):
        self.prim = None
        

'''
crearea unei liste din valori citite pana la 0
'''
def creareLista():
    lista = Lista()
    lista.prim = creareLista_rec()
    return lista

def creareLista_rec():
    x = int(input("x="))
    if x == 0:
        return None
    else:
        nod = Nod(x)
        nod.urm = creareLista_rec()
        return nod
    
'''
tiparirea elementelor unei liste
'''
def tipar(lista):
    tipar_rec(lista.prim)
    
def tipar_rec(nod):
    if nod != None:
        print (nod.e)
        tipar_rec(nod.urm)


'''
point a
'''

def length(nod):
    if nod is None:
        return 0
    else:
        return 1 + length(nod.urm)

def search(nod, x):
    if nod is None:
        return False
    elif nod.e == x:
        return True
    return search(nod.urm, x)

def inclusion(list1, list2):
    if list1 is None or list2 is None:
        return True
    elif length(list1.prim) < length(list2.prim):
        if list1.prim is not None:
            nod = list1.prim.e
            list1.prim = list1.prim.urm
            return search(list2.prim, nod) and inclusion(list1, list2)
        else:
            return True
    elif length(list1.prim) >= length(list2.prim):
        if list2.prim is not None:
            nod = list2.prim.e
            list2.prim = list2.prim.urm
            return search(list1.prim, nod) and inclusion(list1, list2)
        else:
            return True


'''
point b
'''

def remove_occurrences(nod, x):
    if nod is None:
        return None
    elif nod.e == x:
        return remove_occurrences(nod.urm, x)
    else:
        nod.urm = remove_occurrences(nod.urm, x)
        return nod

'''
program pentru test
'''
        
def main():
    print("A. Test the inclusion of two sets, represented as lists.")
    print("list1:")
    list1 = creareLista()
    print("list2:")
    list2 = creareLista()
    print("\n")
    print(inclusion(list1, list2))
    print("\n")
    print("B. Eliminate all occurrences of an element from a list.")
    list = creareLista()
    tipar(list)
    x = int(input("enter element to remove: "))
    print("\n")
    list.prim = remove_occurrences(list.prim, x)
    tipar(list)
    
main() 
    
    
    
    
    