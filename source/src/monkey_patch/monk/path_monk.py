import monk

def monkey_f(self):
	print("monkey_f() is being called")


monk.A.func = monkey_f
obj = monk.A()
obj.func()

