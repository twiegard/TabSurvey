prefix="tabsurvey_"
sklearn_env="$prefix""sklearn"
gbdt_env="$prefix""gdbt"
torch_env="$prefix""torch"
tensorflow_env="$prefix""tensorflow"

set -e

# Set up Sklearn environment
conda create -n "$sklearn_env" -y -c conda-forge optuna configargparse pandas scikit-learn ipykernel
#conda install -n "$sklearn_env" -y -c anaconda ipykernel
#----------
#conda run -n "$sklearn_env" python -m ipykernel install --user --name="$sklearn_env"
#----------


# Set up GBDT environment
conda create -n "$gbdt_env" -y -c conda-forge ipykernel optuna configargparse pandas xgboost catboost lightgbm scikit-learn
#conda install -n "$gbdt_env" -y -c conda-forge ipykernel optuna configargparse pandas
#----------
#conda run -n "$gbdt_env" python -m ipykernel install --user --name="$gbdt_env"
#----------
conda run -n "$gbdt_env" python -m pip install https://github.com/schufa-innovationlab/model-trees/archive/master.zip
#conda run -n "$gbdt_env" python -m pip install catboost==1.0.3
#conda run -n "$gbdt_env" python -m pip install lightgbm==3.3.1
#conda install -n "$gbdt_env" -y -c conda-forge optuna configargparse pandas

# For ModelTrees
#conda run -n "$gbdt_env" python -m pip install https://github.com/schufa-innovationlab/model-trees/archive/master.zip


# Set up Pytorch environment
conda config --set channel_priority flexible
conda create -n "$torch_env" -y -c pytorch -c conda-forge python=3.10 ipykernel optuna configargparse scikit-learn pandas matplotlib shap pytorch cudatoolkit captum pytorch-tabnet requests lightgbm einops tabulate yacs pytorch-lightning wandb loguru ray-all numpy lifelines scipy h5py tensorboard
conda config --set channel_priority strict
#----------
#conda run -n "$torch_env" python -m ipykernel install --user --name="$torch_env"
#----------

# For TabNet
conda run -n "$torch_env" python -m pip install qhoptim stg https://github.com/AmrMKayid/nam/archive/main.zip --no-deps

# For NODE
#conda run -n "$torch_env" python -m pip install requests
#conda run -n "$torch_env" python -m pip install qhoptim

# For DeepGBM
#conda run -n "$torch_env" python -m pip install lightgbm==3.3.1

# For TabTransformer
#conda run -n "$torch_env" python -m pip install einops

# For STG
#conda run -n "$torch_env" python -m pip install stg==0.1.2

# For NAM
#conda run -n "$torch_env" python -m pip install https://github.com/AmrMKayid/nam/archive/main.zip
#conda run -n "$torch_env" python -m pip install tabulate

# For DANet
#conda run -n "$torch_env" python -m pip install yacs


# Set up Keras environment
conda config --set channel_priority flexible
conda create -n "$tensorflow_env" -y -c anaconda -c conda-forge tensorflow=1.15.0 keras ipykernel optuna configargparse scikit-learn pandas
conda config --set channel_priority strict
#conda install -n "$tensorflow_env" -y -c anaconda ipykernel
#conda install -n "$tensorflow_env" -y -c conda-forge optuna configargparse scikit-learn pandas