##########################################
#   Skeleton Jigsaw
#   http://plaev.github.com
##########################################

NAME = game.min

# Google Closure Compiler Options
GCC_OPTION = --jscomp_off=internetExplorerChecks

#--compilation_level ADVANCED_OPTIMIZATIONS

publish: unify prepare copy prepare-repo update-git
	@echo " ----> Done!"

prepare-repo:
	@echo " ----> Preparing repository"

update-git:
	@echo " ----> Updating git"
	@git checkout index.html
	@cd production && git checkout gh-pages && git commit -am "Updating skeleton jigsaw version" && [[ ! -f config.ru ]]; git push --force && cd ..

copy:
	@echo " ----> Copying to production repository"
	@cp -R index.html game.min.js media/ production/

# Prepare impact to use on plaev games
impact:
	if test -d /Applications; then \
		sed -i '' 's/\.php//g' lib/weltmeister/config.js; \
		sed -i '' 's/cd \.\.//g' tools/bake.sh; \
	else \
		sed -i 's/\.php//g' lib/weltmeister/config.js; \
		sed -i 's/cd \.\.//g' tools/bake.sh; \
	fi

unify:
	@echo " ----> Unifying!"
	@./tools/bake.sh > /dev/null

prepare:
	@echo " ----> Preparing HTML"
	@if test -d /Applications; then \
		sed -i '' 's/<script type="text\/javascript" src="lib\/impact\/impact.js"><\/script>//g' index.html; \
		sed -i '' 's/<script type="text\/javascript" src="lib\/game\/main.js"><\/script>//g' index.html; \
		sed -i '' 's/<!-- <script type="text\/javascript" src="game.min.js"><\/script> -->/<script type="text\/javascript" src="game.min.js"><\/script>/g' index.html; \
	else \
		sed -i 's/<script type="text\/javascript" src="lib\/impact\/impact.js"><\/script>//g' index.html;\
		sed -i 's/<script type="text\/javascript" src="lib\/game\/main.js"><\/script>//g' index.html;\
		sed -i 's/<!-- <script type="text\/javascript" src="game.min.js"><\/script> -->/<script type="text\/javascript" src="game.min.js"><\/script>/g' index.html;\
	fi


check:
	find lib/game -name "*.js" -exec jshint {} \;

update:
	git add production
	git commit -m "Updating skeleton jigsaw production version"
	git push
