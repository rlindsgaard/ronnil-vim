.default: all
 
.phony: all install
 
all:
	@echo "Use \"make install\" ..."
 
install:
	@echo "Installing into $(HOME) ..."
	@mv -f $(HOME)/.vimrc $(HOME)/.vimrc_backup 2>&1 || true
	@mv -f $(HOME)/.vim $(HOME)/.vim_backup 2>&1 || true
	@install vimrc $(HOME)/.vimrc
	@cp -R vim/ $(HOME)/.vim
	@mkdir -p $(HOME)/.vim/backup
	@mkdir -p $(HOME)/.vim/temp
