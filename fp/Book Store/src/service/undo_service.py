class undoServiceError(Exception):
    '''
    prints an exception related to the undo service class
    '''
    def __init__(self, msg):
        self._msg = msg

class UndoService:
    def __init__(self):
        self._history = []
        self._index = -1

    def record(self, operation):
        '''
        record operation in history
        :param operation: operation on one of the repos
        :return:
        '''
        self._history = self._history[0:self._index + 1]
        self._history.append(operation)
        self._index += 1

    def undo(self):
        if self._index == -1:
            raise undoServiceError("No more undos!")
        self._history[self._index].undo()
        self._index -= 1
        return True

    def redo(self):
        if self._index == len(self._history) - 1:
            raise undoServiceError("No more redos!")
        self._index += 1
        self._history[self._index].redo()
        return True


class Cascade:
    '''
    undo/redo multiple times(specifically for remove client-remove rentals)
    '''
    def __init__(self, *operations):
        self._operations = operations

    def undo(self):
        for operation in self._operations:
            operation.undo()

    def redo(self):
        for operation in self._operations:
            operation.redo()


class Operation:
    def __init__(self, call_undo, call_redo):
        self._call_undo = call_undo
        self._call_redo = call_redo

    def undo(self):
        self._call_undo()

    def redo(self):
        self._call_redo()


class FunctionCall:
    def __init__(self, ref, *params):
        self._ref = ref
        self._params = params

    def call(self):
        return self._ref(*self._params)

    def __call__(self):
        return self.call()