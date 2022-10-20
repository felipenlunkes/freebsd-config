# English

<div align="justify">

The [script](config.sh), present in this directory, is responsible for automating tasks related to the installation of packages not installed by default on a FreeBSD system. The script performs the following tasks:

* Installation and configuration of the Xorg server;
* Installation of kernel modules for the main video cards;
* Installation of the GNU nano text editor and the GNU bash shell;
* Installation and configuration of the KDE Plasma graphical environment and the sddm login manager;
* Creation and editing of configuration files for the graphical environment and for the network interface;
* Updated pkg and FreeBSD catalog (kernel and userland).

The user must only edit the `CARD0` variable, informing the video card he has.

</div>

# Português

<div align="justify">

O [script](config.sh), presente neste diretório, é responsável por automatizar tarefas ligadas à instalação de pacotes não instalados por padrão em um sistema FreeBSD. O script realiza as seguintes tarefas:

* Instalação e configuração do servidor Xorg;
* Instalação de módulos de kernel das principais placas de vídeo;
* Instalação do editor de texto GNU nano e do shell GNU bash;
* Instalação e configuração do ambiente gráfico KDE Plasma e do gerenciador de login sddm;
* Criação e edição de arquivos de configuração para o ambiente gráfico e para interface de rede;
* Atualização do catálogo do pkg e do FreeBSD (kernel e userland).

O usuário deve apenas editar a variável `CARD0`, informando a placa de vídeo que possui.

</div>