import matplotlib.pyplot as plt
import pandas as pd
import argparse


def plot_data(csv_file, output_file):
    df = pd.read_csv(csv_file)

    df = df.groupby("CPU", as_index=False).mean()

    df = df.sort_values(by="CPU")
    print(df)

    # Compute speedup (T1 / TP)
    baseline_time = df[df["CPU"] == df["CPU"].min()]["Time"].values[0]
    df["Speedup"] = baseline_time / df["Time"]
    df["IdealSpeedup"] = df["CPU"]  # Ideal strong scaling


    plt.figure(figsize=(8,6))
    plt.plot(df["CPU"], df["Speedup"], marker='o', label="Measured Speedup")
    
    plt.xscale("log", base=2)
    plt.xlabel("Number of CPUs")
    plt.ylabel("Speedup")
    plt.title("HMMer Scaling Benchmarking")

    plt.grid(True, which="both", linestyle="--")
        # Save plot
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    
    # Show plot
    plt.show()
    plt.show()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Plot strong scaling from a CSV file.")
    parser.add_argument("csv_file", type=str, help="Path to the CSV file")
    parser.add_argument("output_file", type=str, help="Path to save output image")
    args = parser.parse_args()

    plot_data(args.csv_file, args.output_file)
