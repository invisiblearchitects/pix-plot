FROM ubuntu:20.04
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN apt update && apt install -y curl 
RUN curl https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh >> anaconda.sh
RUN chmod 775 anaconda.sh
RUN yes yes | ./anaconda.sh
RUN printf 'import image_datasets\nimage_datasets.oslomini.download()' >> fetchimages.py
RUN source ./root/.bashrc && \
    conda create --name tf14 --no-channel-priority tensorflow==1.14
RUN conda activate tf14 && \
    pip install https://github.com/yaledhlab/pix-plot/archive/master.zip && \
    pip install image_datasets && \
    python ./fetchimages.py && \
    pixplot --images "datasets/oslomini/images/*" --metadata "datasets/oslomini/metadata/metadata.csv"
RUN python -m http.server 5000

