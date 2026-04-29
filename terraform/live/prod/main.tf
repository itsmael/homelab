module "my_wiki" {
  source = "../../modules/wikijs"

  namespace = "wiki"
  domain    = "wiki.home.lab" 
  db_size   = "2Gi"
}
