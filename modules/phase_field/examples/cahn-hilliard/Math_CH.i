[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 100
  ny = 100
  xmax = 60
  ymax = 60
  elem_type = QUAD4
[]

[Variables]
  [./c]
    order = THIRD
    family = HERMITE
    [./InitialCondition]
      max = .1
      type = RandomIC
      min = -.1
    [../]
  [../]
[]

[Kernels]
  [./c_dot]
    type = TimeDerivative
    variable = c
  [../]
  [./CHbulk]
    type = CHMath
    variable = c
  [../]
  [./CHint]
    type = CHInterface
    variable = c
    mob_name = M
    kappa_name = kappa_c
  [../]
[]

[BCs]
  [./Periodic]
    [./all]
      auto_direction = 'x y'
    [../]
  [../]
[]

[Materials]
  [./mat]
    type = GenericConstantMaterial
    prop_names  = 'M kappa_c'
    prop_values = '1.0 0.5'
    block = 0
  [../]
[]

[Postprocessors]
  [./top]
    type = SideIntegralVariablePostprocessor
    variable = c
    boundary = top
  [../]
[]

[Executioner]
  type = Transient
  dt = 2.0
  l_max_its = 30

  solve_type = 'NEWTON'


  #petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart'
  #petsc_options_value = 'hypre boomeramg 101'
  petsc_options_iname = '-pc_type -ksp_grmres_restart -sub_ksp_type -sub_pc_type -pc_asm_overlap'
  petsc_options_value = 'asm         31   preonly   lu      1'
  l_tol = 1e-4
  end_time = 80.0
  scheme = bdf2
[]

[Outputs]
  exodus = true
  active = console
[]
