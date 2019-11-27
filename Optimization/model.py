# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

"""
Demonstration of a model using the Paraboloid component.
"""
'from __future__ import division, print_function'
import openmdao.api as om
import numpy as np
from math import cos, sin


class Paraboloid(om.ExplicitComponent):
    """
    Evaluates the equation f(x,y) = (x-3)^2 + xy + (y+4)^2 - 3.
    """

    def setup(self):
        self.add_input('length', val=np.zeros(2) )
        self.add_input('kappa', val=np.zeros(3))
        self.add_input('kb', val=np.zeros(3))
        self.add_input('l22',val = 0.0)
        self.add_output('f_xy', val=0.0)

        # Finite difference all partials.
        self.declare_partials('*', '*', method='fd')

    def compute(self, inputs, outputs):
        """
        f(x,y) = (x-3)^2 + xy + (y+4)^2 - 3

        Minimum at: x = 6.6667; y = -7.3333
        """
        length = inputs['length']
        kappa = inputs['kappa']
        kb = inputs['kb']
        l22 = inputs['l22']
        
        outputs['f_xy'] = np.linalg.norm(length[0]*(cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) 
         + sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))) 
         - ((cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2])) - 1)*(kb[0] + kb[1] + kb[2]))/(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]) - 
         (cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*(cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) - 1)*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1]) 
         + (sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1]) - 25)
        
        "'outputs['f_xy'] = (x-3.0)**2 + x*y + (y+4.0)**2 - 3.0'"


if __name__ == "__main__":

    model = om.Group()
    ivc = om.IndepVarComp()
    ivc.add_output('length', [1.0,1.0])
    ivc.add_output('kappa', [1.0,1.0,1.0])
    ivc.add_output('kb', [1.0,1.0,1.0])
    ivc.add_output('l22', 1.0)
    model.add_subsystem('des_vars', ivc)
    model.add_subsystem('parab_comp', Paraboloid())

    model.connect('des_vars.length', 'parab_comp.length')
    model.connect('des_vars.kappa', 'parab_comp.kappa')
    model.connect('des_vars.kb', 'parab_comp.kb')
    model.connect('des_vars.l22', 'parab_comp.l22')
 

    prob = om.Problem(model)
    prob.setup()
    prob.run_model()
    print(prob['parab_comp.f_xy'])

    """prob['des_vars.x'] = 5.0
    prob['des_vars.y'] = -2.0
    prob.run_model()
    print(prob['parab_comp.f_xy'])"""
   