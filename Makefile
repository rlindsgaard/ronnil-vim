.default: all
 
.phony: all install
 
all:
	@echo "Use \"make install\" ..."
 
install:
	@echo "Installing into $(HOME) ..."
	@mv -f $(HOME)/.vimrc $(HOME)/.vimrc_backup 2>&1 || true
	@mv -f $(HOME)/.vim $(HOME)/.vim_backup 2>&1 || true
	@ln -s $(CURDIR)/vim $(HOME)/.vim
	@ln -s $(CURDIR)/vimrc $(HOME)/.vimrc
	@mkdir $(HOME)/.vim/backup
	@mkdir $(HOME)/.vim/temp
