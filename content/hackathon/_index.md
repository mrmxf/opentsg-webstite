---
title:     opentsg
linkTitle: opentsg

---
<!-- ###  Segment boundary ################################################ -->
<div class =  "ui olive segment">
<!-- --- grid ------------------------------------------------------------  -->
  <div class="ui grid">
  <div class="row">
    <!-- --- left column -------------------------------------------------  -->
    <div class="four wide column">
<!-- --- card ------------------------------------------------------------  -->
{{< f/card-centered
      src         =  "/img/logo-otsg.png"
      imgClass    =  "medium"
      header      =  "Women in Streaming Media Hackathon @ Eviden"
      id          =  "hackathon"
      class       = "ui olive fluid card"
>}}

<div class="ui green message">
  Make a test pattern suitable for checking your studio setup
</div>
{{< /f/card-centered >}}
    </div>
    <!-- --- right column ------------------------------------------------  -->
    <div class="twelve wide column">

<div class="ui basic styled accordion">
  <!-- --- accordian 1 ---------------------------------------------------  -->
  <div class="active title">
    <i class="dropdown icon"></i>
    Event Day
  </div>
  <div class="active content">

For the event, the software will run in the cloud, only a browser required.

### Challenge

In the browser you will find a file called `hackathon.ipynb`. Double click on
it to open it in the user interface. This special tutorial will take you about
10 minutes to run through. It will teach you how to include images, logos and
other components into a test pattern that could be used for setting up
displays, studios, lighting or, more importantly and complete end-to-end
virtual studio.

Traditionally test charts have been very engineering oriented with elements
like skin tones being overly biased to a minority of the population. If you
were going to create a test chart for a twitch or tiktok or facebook streaming
event then what would you put on it? Feel free to use images and ideas from the
web. Show us your creativity and be prepared to explain the thinking behind
your creations.

  </div>
  <!-- --- accordian 2 ---------------------------------------------------  -->
  <div class="title">
    <i class="dropdown icon"></i>
    Try it out - Alpha testers
  </div>
 <div class="content">

For the event, all that is required is a web browser. Everything else should be
done in the cloud. If you want to test the system beforehand & run tutorials
1-9 for a full in-depth demo of how it all works, then follow the instructions
below.

  </div>
  <!-- --- accordian 3 ---------------------------------------------------  -->
  <div class="title">
    <i class="dropdown icon"></i>
    Alpha setup - local PC
  </div>
   <div class="content">

<!-- markdownlint-disable MD031 -->
The Docker container holds all the code and executables. Your personal test
signals appear in a `/usr` folder in the interface. This is mapped to an `otsg`
subfolder of your home folder on your machine. The instructions below are the
bare minimum to get you going. See the comments in the start script if you need
to customize how it runs on your system.

### Install

1. Check the [prerequisites](/hackathon/prerequisites/). This is _REALLY_
   important.
2. From docker desktop or the [docker website](https://hub.docker.com/r/mrmxf):
    * **amd** is for _64 bit Intel or AMD Ryzen_ laptops - most people need
      this one
        * `docker pull mrmxf/opentsg-amd:v0.4.1`
    * **arm64** is for _Apple silicon_ & _arm-Windows_ laptops only
        * `docker pull mrmxf/opentsg-arm:v0.4.1`
3. Download the start script `start.cmd` from [downloads](/downloads)
    * **Windows** may give you a security warning. Select the appropriate
     _Keep_ and then _Keep it anyway_ or _I trust this file_ options and
     download to somewhere in your **PATH** or somewhere that you will always
     start `opentsg` from.
    * **Mac** doesn't know (or care) that the file extension `.cmd` is a
      command file. Just save it to somewhere on your **PATH** or somewhere
     that you will always start `opentsg` from.
4. Start Docker desktop or start the docker daemon if the desktop option is not
   available.
   ```bash
    # only needed if you don't have docker desktop running
    sudo systemctl start docker    # for Debian / Ubuntu
    dockerd                        # for other systems
   ```
5. Run the docker container using `start.cmd` from Mac's `Terminal.app` or
   Windows' `cmd`. If `start.cmd` is not in your path, you should `cd` to the
   folder where you downloaded it and run it
   ```sh
   : # Mac: command for Terminal.app
   zsh start.cmd
   : # Windows: command for user mode cmd.exe (not powershell!)
   start.cmd
   : # Linux: command for bash
   bash start.cmd
   ```
6. if the browser does not start automatically, then look in the logs and copy
   the start address and token for your machine. It will look like this, but
   with a _**different** token_:
   ```sh
   http://127.0.0.1:8888/lab?token=3b3ecb922417c0835f8fb26dfd6424a7ec114acc0f1308ef
   ```

  </div>
  <!-- --- accordian 4 ---------------------------------------------------  -->
  <div class="title">
    <i class="dropdown icon"></i>
    Alpha software - usage
  </div>
   <div class="content">

All tset signal definitions and patterns saved in the `/usr` folder of
`opentsg-lab` will be preserved in the `otsg` subfolder of your home folder.
Any other saved data will probably be reset when to restart the container from
the image!

Always save your new work in the `/usr` folder if you want to keep it.

  </div><!-- --- accordian section end -----------------------------------  -->
</div><!-- --- accordian end ---------------------------------------------  -->
      </div><!-- --- column end ------------------------------------------  -->
    </div><!-- --- row end -----------------------------------------------  -->
  </div><!-- --- grid end ------------------------------------------------  -->
 <!-- --- segment end ----------------------------------------------------  -->
</div>

<!-- ###  Row boundary #################################################### -->
