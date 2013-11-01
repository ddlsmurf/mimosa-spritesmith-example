# Force local mimosa bin
NPMEXEC   = PATH="`npm bin`:$(PATH)"
MIMOSA    = $(NPMEXEC) mimosa
watch = $(MIMOSA) watch
build = $(MIMOSA) build
sprites = $(MIMOSA) spritesmith

SPRITE_SRC = sprites/
SPRITE_OUT_IMG = assets/images/
SPRITE_OUT_CSS = assets/stylesheets/
SPRITE_OUT_PUBLIC_IMG = $(SPRITE_OUT_IMG:assets/%=public/%)
SPRITE_CSS_FORMAT = styl
SPRITE_IMG_FORMAT = png

.PHONY : start startd build build-opt buildo clean pack package

start: spritesmith
	@echo "[x] Building assets and starting development server..."
	@$(watch) -s

startd:
	@echo "[x] Cleaning compiled directory, building assets and starting development server.."
	@$(watch) -sd

build: spritesmith
	@echo "[x] Building assets..."
	@$(build)

build-opt:
	@echo "[x] Building and optimizing assets..."
	@$(build) -o

buildo:
	@echo "[x] Building and optimizing assets..."
	@$(build) -o

clean: spritesmith-clean
	@echo "[x] Removing compiled files..."
	@$(MIMOSA) clean

pack:
	@echo "[x] Building and packaging application..."
	@$(build) -omp

package:
	@echo "[x] Building and packaging application..."
	@$(build) -omp

SPRITE_LIST = $(filter-out common,$(notdir $(wildcard $(SPRITE_SRC)*)))
SPRITE_IMAGES = $(SPRITE_LIST:%=$(SPRITE_OUT_IMG)%.$(SPRITE_IMG_FORMAT))
SPRITE_CSS = $(SPRITE_LIST:%=$(SPRITE_OUT_CSS)%.$(SPRITE_CSS_FORMAT))
SPRITE_PUBLIC_IMAGES = $(SPRITE_IMAGES:$(SPRITE_OUT_IMG)%=$(SPRITE_OUT_PUBLIC_IMG)%)

.PHONY : spritesmith spritesmith-clean

$(SPRITE_IMAGES) $(SPRITE_CSS): $(SPRITE_SRC)
	@echo "[x] Building sprites..."
	@$(sprites)
spritesmith: $(SPRITE_IMAGES) $(SPRITE_CSS)
spritesmith-clean:
	@echo "[x] Deleting sprites..."
	@-rm -- $(SPRITE_IMAGES) $(SPRITE_CSS) $(SPRITE_PUBLIC_IMAGES)
