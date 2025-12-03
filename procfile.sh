#!/usr/bin/env bash

# Check if ONLYOFFICE_MODE is set
if [ -z "$ONLYOFFICE_MODE" ]; then
  echo "[ERROR] The ONLYOFFICE_MODE environment variable is not set."
  echo "Possible values: docservice, fileconverter, proxy"
  exit 1
fi

PROCFILE_PATH="${build_dir}/Procfile"

case "$ONLYOFFICE_MODE" in
  docservice)
    cat << EOF > "$PROCFILE_PATH"
docservice: start $ONLYOFFICE_MODE
postdeploy: postdeploy
EOF
    ;;

  fileconverter)
    cat << EOF > "$PROCFILE_PATH"
fileconverter: start $ONLYOFFICE_MODE
EOF
    ;;
  
  *)
    echo "[ERROR] Unknown value for ONLYOFFICE_MODE: '$ONLYOFFICE_MODE'"
    echo "Valid values: docservice | fileconverter"
    exit 1
    ;;
esac