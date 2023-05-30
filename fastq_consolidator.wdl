version 1.0

struct Sequence {
  File? bam
  File? fastq1
  File? fastq2
}

struct SequenceData {
  Sequence sequence
  String? readgroup
}

task consolidate {
  input {
    File fastq1
    File fastq2
    String readgroup
  }

  SequenceData sd = object { sequence: object { fastq1: fastq1, fastq2: fastq2 }, readgroup: readgroup }

  command {
    echo "processing..."
  }

  output {
    SequenceData sequence_data = sd
  }

  runtime {
    docker: "ubuntu:xenial"
    memory: "1GB"
  }
}

workflow SequenceObjectConsolidator {
  input {
    File fastq1
    File fastq2
    String readgroup
  }

  call consolidate {
    input:
      fastq1 = fastq1,
      fastq2 = fastq2,
      readgroup = readgroup
  }

  output {
    SequenceData sequence_data = consolidate.sequence_data
  }
}

