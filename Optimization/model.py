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
        self.add_input('length1', val=0.0)
        self.add_input('length2', val=0.0)
        self.add_input('length3', val=0.0)
        self.add_input('length4', val=0.0)
        self.add_input('kappa1', val=0.0)
        self.add_input('kappa2', val=0.0)
        self.add_input('kappa3', val=0.0)
        self.add_input('kb1', val=0.0)
        self.add_input('kb2', val=0.0)
        self.add_input('kb3', val=0.0)
        self.add_input('l22', val=0.0)
        self.add_output('f_xy', val=0.0)

        # Finite difference all partials.
        self.declare_partials('*', '*', method='fd')

    def compute(self, inputs, outputs):
        """
        f(x,y) = (x-3)^2 + xy + (y+4)^2 - 3

        Minimum at: x = 6.6667; y = -7.3333
        """
        length1 = inputs['length1']
        """length2 = inputs['length2']"""
        length3 = inputs['length3']
        length4 = inputs['length4']
        """kappa1 = inputs['kappa1']"""
        kappa2 = inputs['kappa2']
        kappa3 = inputs['kappa3']
        kb1 = inputs['kb1']
        kb2 = inputs['kb2']
        kb3 = inputs['kb3']
        l22 = inputs['l22']
        def F_kinematics_x(inputs):
           """ptip = np.linalg.norm(length1*(cos((length3*(kappa1*kb1 + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) 
            + sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))) 
            - ((cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2])) - 1)*(kb[0] + kb[1] + kb[2]))/(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]) - 
            (cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*(cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) - 1)*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1]) 
            + (sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1]))
           """
           kappa1 = 0
           ptip_x = length1*(cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22-length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) + sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*cos(((l22-length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))) - ((cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3)) - 1)*(kb1 + kb2 + kb3))/(kappa1*kb1 + kappa2*kb2 + kappa3*kb3) - (cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*(cos(((l22-length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) - 1)*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2) + (sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22-length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2)
           return ptip_x
        def F_kinematics_z(inputs):
           """ptip = np.linalg.norm(length1*(cos((length3*(kappa1*kb1 + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) 
            + sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))) 
            - ((cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2])) - 1)*(kb[0] + kb[1] + kb[2]))/(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]) - 
            (cos((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*(cos(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1])) - 1)*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1]) 
            + (sin((length[1]*(kappa[0]*kb[0] + kappa[1]*kb[1] + kappa[2]*kb[2]))/(kb[0] + kb[1] + kb[2]))*sin(((l22 - length[1])*(kappa[0]*kb[0] + kappa[1]*kb[1]))/(kb[0] + kb[1]))*(kb[0] + kb[1]))/(kappa[0]*kb[0] + kappa[1]*kb[1]))
           """
           kappa1 = 0
           ptip_z =  length4 + length1*(cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*cos(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) - sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))) + (sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*(kb1 + kb2 + kb3))/(kappa1*kb1 + kappa2*kb2 + kappa3*kb3) + (sin((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*(cos(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2)) - 1)*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2) + (cos((length3*(kappa1*kb1 + kappa2*kb2 + kappa3*kb3))/(kb1 + kb2 + kb3))*sin(((l22 - length3)*(kappa1*kb1 + kappa2*kb2))/(kb1 + kb2))*(kb1 + kb2))/(kappa1*kb1 + kappa2*kb2)
           return ptip_z
        outputs['f_xy'] = np.linalg.norm(F_kinematics_x(inputs)-30+F_kinematics_z(inputs)-30)
        
        # "'outputs['f_xy'] = (x-3.0)**2 + x*y + (y+4.0)**2 - 3.0'"


if __name__ == "__main__":

    model = om.Group()
    ivc = om.IndepVarComp()
    ivc.add_output('length1', 1.0)
    """ivc.add_output('length2', 1.0)"""
    ivc.add_output('length3', 1.0)
    """ivc.add_output('kappa1', 1.0)"""
    ivc.add_output('kappa2', 1.0)
    ivc.add_output('kappa3', 1.0)
    ivc.add_output('kb1', 1.0)
    ivc.add_output('kb2', 1.0)
    ivc.add_output('kb3', 1.0)
    ivc.add_output('l22', 1.0 )
    model.add_subsystem('des_vars', ivc)
    model.add_subsystem('parab_comp', Paraboloid())

    model.connect('des_vars.length1', 'parab_comp.length1')
    model.connect('des_vars.length3', 'parab_comp.length3')
    """model.connect('des_vars.kappa1', 'parab_comp.kappa1')"""
    model.connect('des_vars.kappa2', 'parab_comp.kappa2')
    model.connect('des_vars.kappa3', 'parab_comp.kappa3')
    model.connect('des_vars.kb1', 'parab_comp.kb1')
    model.connect('des_vars.kb2', 'parab_comp.kb2')
    model.connect('des_vars.kb3', 'parab_comp.kb3')
    model.connect('des_vars.l22', 'parab_comp.l22')
 

    prob = om.Problem(model)
    prob.setup()
    prob.run_model()
    print(prob['parab_comp.f_xy'])

    """prob['des_vars.x'] = 5.0
    prob['des_vars.y'] = -2.0
    prob.run_model()
    print(prob['parab_comp.f_xy'])"""
   