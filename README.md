# dotfiles

## Notes

- To fix `zsh compinit: insecure directories, run compaudit for list.`, run:

  ```sh
  compaudit | xargs chmod g-w
  ```

  See: https://stackoverflow.com/a/22753363
