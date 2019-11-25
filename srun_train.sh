now=$(date +"%Y%m%d_%H%M%S")

export PYTHONPATH=/mnt/lustre/hantao/anaconda3/envs/deepSLAM/lib/python3.6/site-packages
export LD_LIBRARY_PATH=/mnt/lustre/share/cuda-9.0/lib64/:$LD_LIBRARY_PATH

if [ ! -d "srun_logs" ]; then
  mkdir srun_logs
fi

jobname=baseline
num_gpus=1

srun -p Robot --job-name=$jobname --gres=gpu:$num_gpus --kill-on-bad-exit=1 \
python train.py --model_name mono_model \
--data_path /mnt/lustre/hantao/Datasets/data_kitti_raw \
--log_dir /mnt/lustre/hantao/monodepth2 \
2>&1|tee srun_logs/$jobname-$now.log &\
