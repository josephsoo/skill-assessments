Q1: What is your home directory?

A: /home/ubuntu

Q2: What is the output of this command?

A: hello_world.txt

Q3: What is the output of each `ls` command?

A: ls on my_folder does nothing, ls on my_folder2 produces hello_world.txt

Q4: What is the output of each?

A: ls does nothing on my_folder and my_folder2, but ls on my_folder3 produces hello_world.txt

Q5: What editor did you use and what was the command to save your file changes?

A: Using nano, I pressed CTRL-O followed by enter to save

Q6: What is the error?

A: Permission denied (publickey).
It lacks an authorized_keys file in SSH, which specifies the SSH keys which can be used for logging into the serveruser.


Q7: What was the solution?

A: I created a .ssh directory, added the authorized_keys file, changed its permission to 600 (giving myself read + write permission), and copy pasted the public key from my ubuntu user's authorized_keys file to the authorized_keys file for serveruser.

Q8: what does the `sudo docker run` part of the command do? and what does the `salmon swim` part of the command do?

A: The docker run command is used to create and start a new container based on the `combinelab/salmon` image , wheras `salmon swim` performs a super secret operaiton

Q9: What is the output of this command?

A: serveruser is not in the sudoers file.  This incident will be reported.

Q10: What is the output of `flask --version`?

A:
Python 3.10.10
Flask 2.3.2
Werkzeug 2.3.6

Q12: What is the output of `which python`

A: /home/serveruser/mambaforge/envs/py27/bin/python

Q13: What is the output of `which python` now?

A: /home/serveruser/mambaforge/bin/python

Q14: What is the output of `salmon -h`?

A: 
salmon v1.4.0

Usage:  salmon -h|--help or 
        salmon -v|--version or 
        salmon -c|--cite or 
        salmon [--no-version-check] <COMMAND> [-h | options]

Commands:
     index      : create a salmon index
     quant      : quantify a sample
     alevin     : single cell analysis
     swim       : perform super-secret operation
     quantmerge : merge multiple quantifications into a single file

Q15: What does the `-o athal.fa.gz` part of the command do?

A: -o athal.fa.gz makes the command output to athal.fa.gz instead of stdout. 

Q16: What is a `.gz` file?

A: a `.gz` file is a file that has been **compressed** using the standard GNU zip (gzip) compression algorithm for Linux and Unix operating systems

Q17. What does the `zcat` command do?

A: zcat **expands the .gz file** without having to decompress it, and outputs the output to **stdout**

Q18. what does the `head` command do?

A: `head` prints the first lines of the input to stdout

Q19. what does the number `100` signify in the command?

A: `100` signifies that the **first 100 lines are printed**.

Q20. What is `|` doing?** -- **Hint** using `|` in Linux is called "piping"  

A: The pipe operator `|` allows the stdout on the left to be piped into to the stdin on the right

Q21. What is a `.fa` file? What is this file format used for?

A: An FA file contains either **nucleic acid sequence (such as DNA) or protein sequence information**.

Q22: What format are the downloaded sequencing reads in? 

A: The format is **.sra**

Q23: What is the total size of the disk?

A: The total size of the disk is **7.6G**

Q24: How much space is remaining on the disk?

A: **1.3G** is remaining on the disk

Q25: What went wrong?

A: 
fastq-dump.2.11.0 err: storage exhausted while writing file within file system module - system bad file descriptor error fd='5'
> many of those were printed to the console

An error occurred during processing.
A report was generated into the file '/home/serveruser/ncbi_error_report.txt'.
If the problem persists, you may consider sending the file
to 'sra-tools@ncbi.nlm.nih.gov' for assistance.


> Essentialy, the server ran out of storage

Q26: I modified the command to **fastq-dump --gzip SRR074122**, outputting as a .gz file

