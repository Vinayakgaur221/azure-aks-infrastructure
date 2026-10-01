module "resource_group" {
  source = "../../child-modules/resource-group"

  rgss = var.rgss
}

module "networking" {
  source = "../../child-modules/networking"

  vnt  = var.vnt
  sbnt = var.sbnt
  nsgg = var.nsgg

  depends_on = [module.resource_group]
}

module "monitoring" {
  source = "../../child-modules/monitoring"

  mntr = var.mntr

  depends_on = [module.resource_group]
}

module "key_vault" {
  source = "../../child-modules/key-vault"

  keyv = var.keyv

  depends_on = [module.resource_group]
}

module "container_registry" {
  source = "../../child-modules/container-registry"

  contrg = var.contrg

  depends_on = [module.resource_group]
}

module "application_gateway" {
  source = "../../child-modules/application-gateway"

  appg = var.appg
  pblc = var.pblc

  depends_on = [module.resource_group, module.networking]
}

module "identity" {
  source = "../../child-modules/identity"

  uai = var.uai
  fic = var.fic
  ra  = var.ra

  depends_on = [module.resource_group]
}

module "aks" {
  source = "../../child-modules/aks"

  kbcl = var.kbcl

  depends_on = [
    module.resource_group,
    module.networking,
    module.identity,
    module.monitoring,
    module.container_registry
  ]
}
