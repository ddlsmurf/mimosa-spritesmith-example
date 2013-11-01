# Mimosa Spritesmith Example

Simple example of retina friendly sprite sheets using mimosa and stylus

In this example, I did not want the sprites copied along so I moved them out of
`assets`, they are now in the root folder `sprites`.

I also replaced the default stylus template for better control from stylus.

## Requirements

You will need a rendering option setup as per [spritesmith's documentation](https://github.com/Ensighten/spritesmith#requirements).

Use correct versions of npm packages: `npm install`.

## Generating a pair of sprites

I use imagemagick in the examples below, but simply ensure you are generating
two sheets, `index` and `index@2x`.

Generate your lower resolution files:

    cd sprites/index@2x
    for i (*.png) do; convert $i -resize 50% ../index/$i; done

> For this example I didn't have high quality images so I used the reverse
and made the retina versions redish:

    cd sprites/index
    for i (*.png) do; convert $i -resize 200% -fill red -tint 60% ../index@2x/$i; done

## Compile

    npm install
    make
    open public/index.html

## What's happening

The `makefile` is running `mimosa spritesmith` which runs
the [mimosa-spritesmith](https://github.com/ddlsmurf/mimosa-spritesmith)
module. This modules creates, for each folder in `/sprites`:

- A spritesheet image in `assets/images/<sprite_folder_name>.png`
- A stylesheet file in `assets/stylesheets/<sprite_folder_name>.styl`

The stylesheet files are formated as per a json2css template setup in
the `mimosa-config.coffee` file.

The `make` then runs `mimosa watch -s` which will compile
`assets/stylesheets/style.styl`, which in turn includes
both generated stylesheets, and creates CSS selectors for
each sprite.

## Troubleshooting

### Stylus version

    File [[ /mimosa-spritesmith-example/assets/stylesheets/index.styl ]] failed compile. Reason: ParseError: /mimosa-spritesmith-example/assets/stylesheets/index.styl:2
       1| // Sprite index
     > 2| $index = {
       3|   image: '../images/index.png',
       4|   width: 44px,
       5|   height: 38px,

    invalid right-hand side operand in assignment, got "{"

Update your stylus version, make sure its at least 1.39. Using
a recent Mimosa version should do the trick so try the section below
first.

### Mimosa version

A recent mimosa version is required for stylus.

  Unable to start Mimosa for the following reason(s):
   * Your version of Mimosa [[ some older version ]] is less than the required version for this project [[ 1.0.12 ]]

Make sure you are using an up to date version, you can do so by
running `npm install` in the current folder, and

- either using the `make` commands
- adding the local npm path to each mimosa command

        PATH=`npm bin`:${PATH} mimosa watch

It might be possible to [force only stylus](https://github.com/ddlsmurf/mimosa-spritesmith/commit/06ad91c3a87da45e797c174406e889927019e512#commitcomment-4482514)'s version.
