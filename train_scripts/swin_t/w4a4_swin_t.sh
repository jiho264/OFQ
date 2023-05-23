## traing of 4-bit Swin-T
python3 train.py -c./configs/swin_t_imagenet.attn_q.yml --model swin_t \
your_path/dataset/imagenet-1k/imagenet \
--dataset 'torch/imagenet' \
--epochs 300 \
--batch-size 64 \
--weight-decay 0.0 \
--warmup-lr 1.0e-6 \
--lr 2.0e-4 \
--warmup-epochs 0 \
--aq-enable \
--aq-mode lsq \
--aq-per-channel \
--aq_clip_learnable \
--aq-bitw 4 \
--wq-enable \
--wq-per-channel \
--wq-bitw 4 \
--wq-mode statsq \
--model_type swin \
--teacher_type swin \
--quantized \
--pretrained \
--pretrained_initialized \
--use-kd --teacher swin_t \
--kd_hard_and_soft 1 \
--qk_reparam \
--qk_reparam_type 0 \
--teacher_pretrained \
--output ./outputs/w4a4_swin_t_qkreparam/ \
--visible_gpu '0,1,2,3,4,5,6,7' \
--world_size '8' \
--tcp_port '12345'

## Fine tune with CGA
python3 cga.py -c./configs/swin_t_imagenet.attn_q.yml --model swin_t \
your_path/dataset/imagenet-1k/imagenet \
--dataset 'torch/imagenet' \
--epochs 300 \
--batch-size 64 \
--weight-decay 0.0 \
--warmup-lr 1.0e-6 \
--lr 2.0e-4 \
--warmup-epochs 0 \
--aq-enable \
--aq-mode lsq \
--aq-per-channel \
--aq_clip_learnable \
--aq-bitw 4 \
--wq-enable \
--wq-per-channel \
--wq-bitw 4 \
--wq-mode statsq \
--model_type swin \
--teacher_type swin \
--quantized \
--pretrained \
--pretrained_initialized \
--use-kd --teacher swin_t \
--kd_hard_and_soft 1 \
--qk_reparam \
--qk_reparam_type 1 \
--boundaryRange 0.005 \
--freeze_for_n_epochs 30 \
--teacher_pretrained \
--resume put the model you wish to finetune here \
--output ./outputs/w4a4_swin_t_qkreparam/ \
--visible_gpu '0,1,2,3,4,5,6,7' \
--world_size '8' \
--tcp_port '12345'