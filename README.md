# www-opentsg
Built with github.com/mrmxf/fohuw.

## Forking, cloning & editing

Once you've (cloned or forked & cloned) the repo, you need to install [git],
[golang] v1.21.5, [node] v18.17.0 and [hugo] v0.121.1+ in your development
environment. My preference was to use [gitpod] which runs VS Code in your
browser (on a phone on a train) as the dev environment to ensure I could update
the site from anywhere, anytime on any device 😃.

The Mr MXF website uses the [hugo] modules feature for the fohuw theme and the
svelte user interaction widgets.

### Step by step dev environment setup (e.g. for mac)

1. clone the site
   * `git clone https://gitlab.com/mm-eng/www-mrmxf.git``
2. install the [extended](https://gohugo.io/installation) version of Hugo
   * e.g. **mac** `brew install hugo`
   * e.g. **windows**
      ```
      wsl
      cd /tmp
      curl -L  --output hugo.tgz https://github.com/gohugoio/hugo/releases/download/v0.121.2/hugo_extended_0.121.2_linux-amd64.tar.gz
      tar zxvf hugo.tgz && chmod +x hugo
      sudo mv hugo /usr/local/bin && hugo version
      npm install -g sass
      ```
      note that it's the linux install inside wsl inside windows.
3. Install [Dart Sass](https://gohugo.io/hugo-pipes/transpile-sass-to-css/#dart-sass)
   * e.g. mac `brew install sass/sass/sass`
   * e.g. ubuntu `sudo snap install dart-sass`
   * e.g. ci/cd `npm ci -g sass`
4. execute the following:
  *

```bash
# install node packages with yarn
go get
hugo
```

[Docsy]:             https://github.com/google/docsy
[fomantic ui]:       https://fomantic-ui.com/
[git]:               https://git-scm.com
[gitpod]:            https://www.gitpod.io/
[golang]:            https://go.dev/doc/install
[Hugo]:              https://gohugo.io/installation/
[Hugo theme module]: https://gohugo.io/hugo-modules/use-modules/#use-a-module-for-a-theme
[node]:              https://nodejs.org/en/download

## deploying

Build the docker file and push it to your favorite image registry. On the host
use this style of execution:

```sh
# pull the docker image

# run the docker image for a proxy forwarder on port 10000
docker run -d -p 10000:80 mrx-static

# check it's working
curl localhost:10000
```

## The videos and downloads don't show

Due to the massive size of some of the content referenced on the site the
NGINX front end is configured to dynamically mount the folders listed in the
folder `assets/deploy/mounts.yaml`.
