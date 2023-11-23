if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR nvim
    alias vim nvim
    fish_vi_key_bindings

    fish_add_path -U ~/go/bin



    # Maybe fix gcloud auth stuff
    set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True

    set -gx PATH $PATH $HOME/.krew/bin

    source ./secrets.fish

end
fish_add_path /usr/local/opt/libpq/bin
