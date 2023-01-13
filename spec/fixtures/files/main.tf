module "my-module" {
  source = "./fake_mod"

  is_this_a_test = "most-definitely"
}

module "my-other-module-with-defaults" {
  source = "./fake_mod"
}