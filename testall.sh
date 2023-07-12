#!/bin/bash

N_TRIALS=2
EPOCHS=3

SKLEARN_ENV="tabsurvey_sklearn"
GBDT_ENV="tabsurvey_gdbt"
TORCH_ENV="tabsurvey_torch"
KERAS_ENV="tabsurvey_tensorflow"

# "LinearModel" "KNN" "DecisionTree" "RandomForest"
# "XGBoost" "CatBoost" "LightGBM"
# "MLP" "TabNet" "VIME"
# MODELS=( "LinearModel" "KNN" "DecisionTree" "RandomForest" "XGBoost" "CatBoost" "LightGBM" "MLP" "TabNet" "VIME")

declare -A MODELS
MODELS=( ["LinearModel"]=$SKLEARN_ENV
         ["KNN"]=$SKLEARN_ENV
         #["SVM"]=$SKLEARN_ENV
         ["DecisionTree"]=$SKLEARN_ENV
         ["RandomForest"]=$SKLEARN_ENV
         ["XGBoost"]=$GBDT_ENV
         ["CatBoost"]=$GBDT_ENV
         ["LightGBM"]=$GBDT_ENV
         ["MLP"]=$TORCH_ENV
         ["TabNet"]=$TORCH_ENV
         ["VIME"]=$TORCH_ENV
         ["TabTransformer"]=$TORCH_ENV
         ["ModelTree"]=$GBDT_ENV
         ["NODE"]=$TORCH_ENV
#         ["DeepGBM"]=$TORCH_ENV #TypeError: ufunc 'isnan' not supported for the input types, and the inputs could not be safely coerced to any supported types according to the casting rule ''safe''
#         ["RLN"]=$KERAS_ENV #Fehler
#         ["DNFNet"]=$KERAS_ENV #AttributeError: module 'tensorflow' has no attribute 'placeholder'
#         ["STG"]=$TORCH_ENV  #Fehler: AttributeError: module 'collections' has no attribute 'Sequence'
#         ["NAM"]=$TORCH_ENV #Fehler
         ["DeepFM"]=$TORCH_ENV
         ["SAINT"]=$TORCH_ENV
         ["DANet"]=$TORCH_ENV
        )

CONFIGS=( "config/adult.yml" 
          "config/covertype.yml"
          "config/california_housing.yml"
          "config/higgs.yml"
        )

# conda init bash
eval "$(conda shell.bash hook)"

for config in "${CONFIGS[@]}"; do

  for model in "${!MODELS[@]}"; do
    printf "\n\n----------------------------------------------------------------------------\n"
    printf 'Training %s with %s in env %s\n\n' "$model" "$config" "${MODELS[$model]}"

    conda activate "${MODELS[$model]}"

    python train.py --config "$config" --model_name "$model" --n_trials $N_TRIALS --epochs $EPOCHS

    conda deactivate

  done

done
