id: default-README
name: Adds a required README.md
description: |-
  Make sure that we always have this required
  README.md file in all repos.
type: required_file
config:
  files:
    - path: README.md
      content: |
        # REQUIRED
                
        This file is required for all zxiiro-testorg repos.
