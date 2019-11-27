# -*- coding: utf-8 -*-
"""
Created on Tue Nov 26 17:03:44 2019

@author: Morimoto Lab
"""
import openmdao.api as om
import numpy as np
from model import Paraboloid

# We'll use the component that was defined in the last tutorial


# build the model
prob = om.Problem()
indeps = prob.model.add_subsystem('indeps', om.IndepVarComp())
"""indeps.add_output('x', 3.0)
indeps.add_output('y', -4.0)"""
indeps.add_output('length', np.array([1.0,1.0]))
indeps.add_output('kappa', np.array([1.0,1.0,1.0]))
indeps.add_output('kb', np.array([1.0,1.0,1.0]))
indeps.add_output('l22', 1.0)

prob.model.add_subsystem('parab', Paraboloid())

# define the component whose output will be constrained
"""prob.model.add_subsystem('const', om.ExecComp('g = length[0]*(cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) + sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))) - ((cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2])) - 1)*(kb[0] + kb[1] + kb[2]))/(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]) - (cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*(cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) - 1)*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1]) + (sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1])'))
"""
'''prob.model.connect('indeps.x', ['parab.x', 'const.x'])
prob.model.connect('indeps.y', ['parab.y', 'const.y'])'''
"""
prob.model.connect('indeps.length', ['parab.length','const.length'])
prob.model.connect('indeps.kappa', ['parab.kappa', 'const.kappa'])
prob.model.connect('indeps.kb', ['parab.kb', 'const.kb'])"""
prob.model.connect('indeps.l22', 'parab.l22')
prob.model.connect('indeps.length', 'parab.length')
prob.model.connect('indeps.kappa', 'parab.kappa')
prob.model.connect('indeps.kb', 'parab.kb')

# setup the optimization
prob.driver = om.ScipyOptimizeDriver()
prob.driver.options['optimizer'] = 'SLSQP'

prob.model.add_design_var('indeps.length', lower=0, upper=50)
prob.model.add_design_var('indeps.kappa', lower=0, upper=50)
prob.model.add_design_var('indeps.kb', lower=0, upper=50)
prob.model.add_design_var('indeps.l22', lower=0, upper=50)
prob.model.add_objective('parab.f_xy')

# to add the constraint to the model
"""prob.model.add_constraint('const.g', lower=0, upper=2.)"""
# prob.model.add_constraint('const.g', equals=0.)

prob.setup()
prob.run_driver()

# minimum value
print(prob['parab.f_xy'])

# location of the minimum
print(prob['indeps.length'])
print(prob['indeps.kappa'])
print(prob['indeps.kb'])
print(prob['indeps.l22'])

