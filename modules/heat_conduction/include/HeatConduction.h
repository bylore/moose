#ifndef HEATCONDUCTION_H
#define HEATCONDUCTION_H

#include "Diffusion.h"
#include "Material.h"

//Forward Declarations
class HeatConduction;

template<>
InputParameters validParams<HeatConduction>();

class HeatConduction : public Diffusion
{
public:

  HeatConduction(const std::string & name, InputParameters parameters);

protected:
  virtual Real computeQpResidual();

  virtual Real computeQpJacobian();

private:
  MaterialProperty<Real> & _k;
  const bool _has_k_dT;
  MaterialProperty<Real> * const _k_dT;
};
#endif //HEATCONDUCTION_H
