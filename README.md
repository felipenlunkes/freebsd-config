<div align="center">

<h1> New FreeBSD installation config script</h1>

![](https://img.shields.io/github/license/felipenlunkes/freebsd-config.svg)
![](https://img.shields.io/github/stars/felipenlunkes/freebsd-config.svg)
![](https://img.shields.io/github/issues/felipenlunkes/freebsd-config.svg)
![](https://img.shields.io/github/issues-closed/felipenlunkes/freebsd-config.svg)
![](https://img.shields.io/github/issues-pr/felipenlunkes/freebsd-config.svg)
![](https://img.shields.io/github/issues-pr-closed/felipenlunkes/freebsd-config.svg)
![](https://img.shields.io/github/downloads/felipenlunkes/freebsd-config/total.svg)
![](https://img.shields.io/github/release/felipenlunkes/freebsd-config.svg)

</div>

<hr>

## English

<div align="justify">

The [script](config.sh), present in this directory, is responsible for automating tasks related to the installation of packages not installed by default on a FreeBSD system. The script performs the following tasks:

* Installation and configuration of the Xorg server;
* Installation of kernel modules for the main video cards;
* Installation of the GNU nano text editor and the GNU bash shell;
* Installation and configuration of the KDE Plasma graphical environment and the sddm login manager;
* Creation and editing of configuration files for the graphical environment and for the network interface;
* Updated pkg and FreeBSD catalog (kernel and userland).

The user must only edit the `CARD0` variable, informing the video card he has.

To run the script, use:

```
su                 # Change to root user (if not already logged in as root)
chmod +x config.sh # Make the script executable
./config.sh        # Run!
```

</div>

## Português

<div align="justify">

O [script](config.sh), presente neste diretório, é responsável por automatizar tarefas ligadas à instalação de pacotes não instalados por padrão em um sistema FreeBSD. O script realiza as seguintes tarefas:

* Instalação e configuração do servidor Xorg;
* Instalação de módulos de kernel das principais placas de vídeo;
* Instalação do editor de texto GNU nano e do shell GNU bash;
* Instalação e configuração do ambiente gráfico KDE Plasma e do gerenciador de login sddm;
* Criação e edição de arquivos de configuração para o ambiente gráfico e para interface de rede;
* Atualização do catálogo do pkg e do FreeBSD (kernel e userland).

O usuário deve apenas editar a variável `CARD0`, informando a placa de vídeo que possui.

Para executar o script, use:

```
su                 # Alterar para usuário root (caso já não esteja logado como root)
chmod +x config.sh # Tornar o script executável
./config.sh        # Executar!
```

</div>

## Proven results/resultados comprovados!

<p align='center'>
<a href="https://github.com/felipenlunkes"><img src="https://github.com/felipenlunkes/freebsd-config/blob/main/img/screenshot.png"></a>&nbsp;&nbsp;
</p>

Tested 5 times successfully!