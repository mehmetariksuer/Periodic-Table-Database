#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"


ARGUMAN_KONTROLU() {
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    DEVAM_ET $1
  fi
}



DEVAM_ET() {


if [[ "$1" =~ ^[0-9]+$ ]]; then
  CONDITION="p.atomic_number = $1"
else
  CONDITION="e.symbol = '$1' OR e.name = '$1'"
fi



TUM_TABLOLARIN_SORGUSU=$($PSQL "SELECT * FROM properties p JOIN elements e ON e.atomic_number=p.atomic_number JOIN types t ON p.type_id=t.type_id WHERE $CONDITION;")
  echo "$TUM_TABLOLARIN_SORGUSU" | while IFS="|" read atomic_number atomic_mass melting_point_celsius boiling_point_celsius type_id atomic_number2 symbol name type_id2 type 
    do
          if [[ -z $TUM_TABLOLARIN_SORGUSU ]]
        then
          echo "I could not find that element in the database."
        else
        echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
  fi
    done

}

ARGUMAN_KONTROLU $1