terraform {
  required_version = ">= 0.15"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

resource "local_file" "literature" {
  filename = "What_And_Why.txt"
  content = <<EOT
What am I doing?
I'm learning all the devops tools along with the cloud concepts.

Why am I doing it?
I'm trying to learn all these so that I could get a better job with much better salary.
The current salary that I'm getting is not enough. Every month I'm going to a negative balance.
I need a build a new house for myself and my daughter.
I need to buy a new car for her.
I need to give the best education to my kids.
I need to take the burden off my wife.
I want to buy 20 acres of land and practice aggriculture on it.
With the current salary I'll never be able to do all this.
I promised to buy a Xbox to my son last year as his birthday gift, but I could not. 
Do I need this kind of disgraceful job where I'm not even able to afford a Xbox for my son?
Hence I need to study to make all my dreams come true.
EOT

}
