const url = process.env.LAMBDA_URL;
const response = await fetch(url);
const urlStatus = response.status;

test("ascertains that the lambda is live", () => {
    expect(urlStatus).toBe(200);
});