
fn divisors_to(n: usize) -> Vec<usize> {
    let mut div = vec![0; n + 1];
    div[1] = 1;
    for i in 2..=n {
        if div[i] == 0 {
            div[i] = i;
            if i >= div.len() / i {
                continue;
            }
            for j in ((i * i)..div.len()).step_by(i) {
                div[j] = i;
            }
        }
    }
    div
}

fn primes_to(n: usize) -> Vec<usize> {
    divisors_to(n).iter().enumerate().filter(|(i, d)| i >= &2 && &i == d).map(|(i, _)| i).collect()
}
