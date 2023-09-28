#!/bin/bash

# Obtener la lista de ramas locales con cambios pendientes
branches_with_changes=$(git for-each-ref --format '%(refname:short)' --sort -committerdate refs/heads/)

# Iterar sobre cada rama y verificar si tiene cambios pendientes
for branch in $branches_with_changes; do
  # Verificar si la rama tiene cambios pendientes
  changes=$(git log origin/${branch}..${branch})

  if [ -n "$changes" ]; then
    echo "La rama '${branch}' tiene cambios pendientes para hacer push."
  else
    echo "La rama '${branch}' no tiene cambios pendientes."
  fi
done
