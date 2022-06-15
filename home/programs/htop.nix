{ config, lib, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      color_scheme = 5;
      cpu_count_from_one_ = 0;
      delay = 15;
      header_margin = 1;
      show_program_path = 0;
      # Don't want to see other users process
      shadow_other_users = 0;
      # Sort by PERCENT_CPU by default
      tree_sort_key = 46;
      sort_direction = 1;
      # Merge exe, comm and cmdline
      show_merged_command = 1;
      find_comm_in_cmdline = 1;
      strip_exe_from_cmdline = 1;
      # Tree view
      tree_view = 1;
      # Collapse tree view by default
      all_branches_collapsed = 1;
      # Update process name on refresh
      update_process_names = 1;
      # Disable the mouse
      enable_mouse = 0;
      # Show CPU percentage numerically
      show_cpu_usage = 1;
      # Display threads in different color
      highlight_threads = 1;
      hide_kernel_threads = 0;
      hide_userland_threads = 0;
      # Better visual
      highlight_megabytes = 1;
      highlight_base_name = 1;

      fields = with config.lib.htop.fields; [
        PID
        USER
        STATE
        PRIORITY
        NICE
        M_SIZE # M_VIRT
        M_RESIDENT
        M_SHARE
        PERCENT_CPU
        PERCENT_MEM
        TIME
        #ELAPSED
        COMM
      ];
    } // (with config.lib.htop; leftMeters [
      (bar "AllCPUs")
      (bar "CPU")
      (text "Blank")
      (text "Memory")
      (text "Swap")
    ]) // (with config.lib.htop; rightMeters  [
      (text "Systemd")
      (text "Tasks")
      (text "LoadAverage")
      (text "Uptime")
      (text "Blank")
      (text "DiskIO")
      (text "NetworkIO")
    ]);
  };
}
