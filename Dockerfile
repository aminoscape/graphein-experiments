FROM continuumio/miniconda3

# Install get_contact_ticc.py dependencies
RUN conda install scipy numpy scikit-learn matplotlib pandas cython
RUN pip install ticc==0.1.4

# Set up vmd-python library
RUN conda install -c https://conda.anaconda.org/rbetz vmd-python

# Set up getcontacts library
RUN git clone https://github.com/getcontacts/getcontacts.git
RUN echo "export PATH=`pwd`/getcontacts:\$PATH" >> ~/.bashrc
RUN source ~/.bashrc

# Install Biopython & RDKit
RUN conda install biopython
# N.B. DGLLife requires rdkit==2018.09.3
RUN conda install -c conda-forge rdkit==2018.09.3

RUN conda install -c salilab dssp

# Install PyTorch, DGL and DGL LifeSci
RUN conda install pytorch torchvision -c pytorch
RUN conda install pytorch torchvision cpuonly -c pytorch

# Install DGL. N.B. We require 0.4.3 until compatibility with DGL 0.5.0+ is implemented
RUN pip install dgl==0.4.3

# Install DGL LifeSci
RUN conda install -c dglteam dgllife

RUN conda install pytorch-geometric -c rusty1s -c conda-forge

# Install PyMol and IPyMol
RUN conda install -c schrodinger pymol
RUN git clone https://github.com/cxhernandez/ipymol \
    && cd ipymol \
    && pip install .

# Install graphein
RUN git clone https://www.github.com/a-r-j/graphein \
    && cd graphein \
    && pip install -e .

RUN echo 'Done'
